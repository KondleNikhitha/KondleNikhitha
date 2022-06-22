# The name of this view in Looker is "Products"
view: products {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.products ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Brand" in Explore.

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }
  dimension: brand1 {
    type: string
    sql: ${TABLE}.brand
          access_filter: {
          field: products.brand
          user_attribute: company
          ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: category_example_0 {
    group_label: "Formatting Examples"
    label: "Category"
    type: string
    sql: ${TABLE}.category ;;
    html: <p style="text-align:center">{{value}}</p> ;;
  }

  dimension: category_example_1 {
    group_label: "Formatting Examples"
    label: "Category Formatted"
    type: string
    sql: ${TABLE}.category ;;
    html: <p style="color: #166088; background-color: #B3F5F7; font-size: 150%; font-weight: bold; text-align:center">{{value}}</p> ;;
  }
  dimension: product_image {
    group_label: "Formatting Examples"
    sql: ${id} ;;
    html: <img src="http://www.brettcase.com/product_images/{{ value }}.jpg" /> ;;
  }
  measure: total_revenue_formatted {
    type: sum
    group_label: "Formatting Examples"
    sql: ${retail_price} - 0.5;;
    html: {% if value < 0 %}
          <p style="color:red">({{rendered_value}})</p>
          {% else %}
          <p>{{rendered_value}}</p>
          {% endif %}

    format : usd;;
  }
  dimension: artist_name {
    group_label: "Formatting Examples"
    sql: ${TABLE}.artist_name ;;
    link: {
      label: "Google"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
  }
  parameter: item_to_add_up {
    group_label: "Formatting Examples"
    type: unquoted
    allowed_value: {
      label: "Total Sale Price"
      value: "sale_price"
    }
    allowed_value: {
      label: "Total Cost"
      value: "cost"
    }
    allowed_value: {
      label: "Total Profit"
      value: "profit"
    }
  }


  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_retail_price {
    type: sum
    sql: ${retail_price} ;;
  }

  measure: average_retail_price {
    type: average
    sql: ${retail_price} ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count, product_facts.count]
  }
}
