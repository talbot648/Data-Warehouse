# Northwind Cycles — Source System Extracts

These files simulate extracts pulled from **five separate operational systems**:
CRM (customers), a product/supplier catalog (products), internal ops/HR (stores,
employees), a marketing calendar (promotions), and — deliberately kept **separate,
not pre-merged** — the in-store **POS system** and the **e-commerce platform**.
None of this is a clean star schema. Profile it before you model it.

## Files & grain

| File | Source system | Grain (1 row = ...) | Rows |
|---|---|---|---|
| `customers.csv` | CRM | one customer record | ~226 |
| `products.csv` | Product/supplier catalog | one SKU in the catalog | 72 |
| `stores.csv` | Internal ops | one store/channel | 7 |
| `employees.csv` | Internal HR | one staff member | 33 |
| `promotions.csv` | Marketing calendar | one promotional campaign | 9 |
| `pos_orders.csv` | POS (in-store) | one in-store transaction | 696 |
| `pos_order_items.csv` | POS (in-store) | one line within a transaction | ~2,069 |
| `ecommerce_orders.csv` | E-commerce platform | one online order | 465 |
| `ecommerce_order_items.csv` | E-commerce platform | one line item within an order | ~1,407 |

5 Source systems: CRM, ECOM, POS, PIM and Internal


## Why POS and e-commerce look different
These two are the same underlying business event (a sale) captured by two different
systems, and they are **not** shaped the same way — which is realistic, and which is
the point. Some of what's different:

| | POS | E-commerce |
|---|---|---|
| Header key | `transaction_id` (`TXN-######`) | `order_id` (`ORD-######`) |
| Line key | `line_no` (sequential per transaction) | `line_item_id` (`LI-#######`) |
| Customer link | `loyalty_customer_id` — **blank for ~65% of rows** (most in-store shoppers aren't logged in) | `customer_id` — essentially always present |
| Timestamp format | `MM/DD/YYYY HH:MM` | ISO 8601 (`YYYY-MM-DDTHH:MM:SSZ`) |
| Payment field | `tender_type` (`CREDIT_CARD`, `GIFT_CARD`, …) | `payment_gateway` (`stripe`, `paypal`, …) |
| Status vocabulary | `order_status`: `COMPLETED` / `VOIDED` / `REFUNDED` / `OPEN` | `fulfillment_status`: `fulfilled` / `cancelled` / `refunded` / `unfulfilled` |
| Discount representation | `discount_amt` — a dollar amount | `discount_pct` — a percentage |
| Only in this source | `register_id`, `cashier_id` | `shipping_cost`, `currency` |

Reconciling these into one conformed `silver.orders` / `silver.order_items` is real
Silver-layer work: map the two status vocabularies onto one shared set of values,
convert `discount_amt` and `discount_pct` onto a common basis, standardize both
timestamp formats, and decide how to represent "no known customer" for POS rows
that lack a `loyalty_customer_id`.

## Key relationships
- `pos_orders.loyalty_customer_id` / `ecommerce_orders.customer_id` → `customers.customer_id`
- `pos_orders.store_id` → `stores.store_id` (e-commerce has no store — it's channel `S07` conceptually, not present in the file)
- `pos_orders.cashier_id` → `employees.employee_id`
- `pos_orders.discount_code` / `ecommerce_orders.discount_code` → `promotions.promo_code`
- `pos_order_items.transaction_id` → `pos_orders.transaction_id`; `pos_order_items.sku` → `products.product_id`
- `ecommerce_order_items.order_id` → `ecommerce_orders.order_id`; `ecommerce_order_items.product_id` → `products.product_id`

## Known data quality issues (this is realistic — don't assume clean data)
- **customers.csv**: some missing emails/phones, a few near-duplicate customers
  (re-registered under a new `customer_id`), state stored as either abbreviation
  or full name, country stored as both "USA" and "US".
- **products.csv**: a few products missing `unit_cost`.
- **pos_orders.csv / ecommerce_orders.csv**: differing status vocabularies and
  timestamp formats (see table above) — needs conforming before union.
- **pos_order_items.csv / ecommerce_order_items.csv**: a few rows have a blank
  `unit_price`/`price` (decide whether to backfill from `products.csv` or
  exclude/flag them).

## Suggested star schema (a starting point — you can design your own)
- **Fact table**: `fact_sales` at the order-line grain (one row per order item)
- **Dimensions**: `dim_date`, `dim_customer`, `dim_product`, `dim_store`,
  `dim_employee`, `dim_promotion`
- Consider which dimensions warrant **SCD Type 2** (customer address changes,
  product price changes) vs. Type 1 (overwrite).
