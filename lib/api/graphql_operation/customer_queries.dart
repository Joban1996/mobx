

var loginOtpVerify = '''query loginOTPVerify(\$mobileNumber: String!,\$otp: String!,\$websiteId: Int!){ 
loginOTPVerify(mobileNumber: \$mobileNumber,otp: \$otp,websiteId: \$websiteId){
    message
    status
    token
  }
}
''';
var signUpOtpVerify = '''query createAccountOTPVerify(\$mobileNumber: String!,\$otp: String!,\$websiteId: Int!){ 
createAccountOTPVerify(mobileNumber: \$mobileNumber,otp: \$otp,websiteId: \$websiteId){
    message
    status
    
  }
}
''';


var   getUserDetailsNow =  '''
query {
customer {
firstname
lastname
email
mobilenumber
date_of_birth
gender
email
}
}
''';


var getUserDetails =  ''' 
query {
    customer {
    wishlists{
      id
    }
    firstname
    lastname
    email
    date_of_birth
    gender
    mobilenumber
}
}
''';

var categories = '''
query categories(\$filters: CategoryFilterInput!){
 categories(filters: \$filters){
    total_count
    items {
      uid
      level
      name
      path
      image
      children_count
      children {
        uid
        level
        name
        path
        children_count
        children {
          uid
          level
          name
          path
        }
      }
    }
    page_info {
      current_page
      page_size
      total_pages
    }
  }
}  

''';
var products = '''
query products(\$filter: ProductAttributeFilterInput){
  products(filter: \$filter) {
    items {
      name
    image {
        url
        label
      }
      small_image{
          url
          label
      }
      sku
      price_range {
        minimum_price {
          regular_price {
            value
            currency
          }
          final_price {
            value
            currency
          }
          discount {
            amount_off
            percent_off
          }
        
        }
      }
    }
    page_info {
      page_size
    }
  }
}  

''';

var productDescription = '''
query products(\$filter: ProductAttributeFilterInput){
  products(filter: \$filter) {
    items {
      name
      sku
      brand
      model_name
      colour
      memory_storage_capacity
      item_weight   
      product_dimensions
      display_technology
      battery_power_rating
      country_of_manufacture
      form_factor
      os
      other_camera_features
      connectivity_technologies
      review_count
      stock_status

    image {
        url
        label
      }
      small_image{
          url
          label
      }
      media_gallery
      {
          url
          label
      }      
     
       description {
        html
      }
      short_description
      {
        html
      }      
      price_range {
        minimum_price {
          regular_price {
            value
            currency
          }
          final_price {
            value
            currency
          }
          discount {
            amount_off
            percent_off
          }
        
        }
      }
    }
    page_info {
      page_size
    }
  }
}  

''';

var homePageBanner = '''query cmsBlocks(\$identifiers: [String]){ 
  cmsBlocks(identifiers: \$identifiers) {
    items {
      identifier
      title
      content
    }
  }
}
''';

var cmsPages = '''
query cmsPage(\$identifier: String){
  cmsPage(identifier: \$identifier) {
    identifier
    url_key
    title
    content
    content_heading

  }
}
''';

var generateCartId =  '''query customerCart{ 
  customerCart{
    id
  }
}
''';

var cartList =  '''query cart(\$cart_id: String!){ 
    cart(cart_id: \$cart_id) {
    email
    billing_address {
      city
      country {
        code
        label
      }
      firstname
      lastname
      postcode
      region {
        code
        label
      }
      street
      telephone
    }
    shipping_addresses {
      firstname
      lastname
      street
      city
      region {
        code
        label
      }
      country {
        code
        label
      }
      telephone
      available_shipping_methods {
        amount {
          currency
          value
        }
        available
        carrier_code
        carrier_title
        error_message
        method_code
        method_title
        price_excl_tax {
          value
          currency
        }
        price_incl_tax {
          value
          currency
        }
      }
      selected_shipping_method {
        amount {
          value
          currency
        }
        carrier_code
        carrier_title
        method_code
        method_title
      }
    }
    items {
      id
      product {
      stock_status
        name
        sku
        small_image{
          url
          label
      }
price_range {
        minimum_price {
          regular_price {
            value
            currency
          }
          final_price {
            value
            currency
          }
          discount {
            amount_off
            percent_off
          }
        
        }
      }
      }
      quantity
    }
    available_payment_methods {
      code
      title
    }
    selected_payment_method {
      code
      title
    }
    applied_coupons {
      code
    }
    prices {
       subtotal_excluding_tax {
        value
      }
      applied_taxes
      {
        amount{
          value
        }
        label
      }
      discounts {
        amount {
          value
        }
        label
      }
      grand_total {
        value
        currency
      }
    }
  }  
}
''';

var getOrders =  ''' 
query {
  customer {
    orders(
      pageSize: 20
    ) {
      items {
        id
         items{
           product_name
           product_url_key
         }
        number
        order_date
        total {
          grand_total {
            value
            currency
          }
        }
        status
      }
    }
  }
}
''';

var   getOrderDetail =  ''' 
query orders(\$filter: CustomerOrdersFilterInput){
  customer {
    orders(filter: \$filter) {
      total_count
      items {
        id
        shipping_address{
          firstname
          lastname
          street
          city
          postcode
          country_code
          telephone
        }
        number
        order_date
        status
        payment_methods{
          name
          type
          additional_data{
            name
            value
          }
        }
        items {
          product_name
          product_sku
          product_sale_price {
            value
          }
          product_sale_price {
            value
            currency
          }
          quantity_ordered
          quantity_invoiced
          quantity_shipped
        }
        carrier
        shipments {
          id
          number
          items {
            product_name
            quantity_shipped
          }
        }
        total {
          base_grand_total {
            value
            currency
          }
          grand_total {
            value
            currency
          }
          total_tax {
            value
          }
          subtotal {
            value
            currency
          }
          taxes {
            amount {
              value
              currency
            }
            title
            rate
          }
          total_shipping {
            value
          }
          shipping_handling {
            amount_including_tax {
              value
            }
            amount_excluding_tax {
              value
            }
            total_amount {
              value
            }
            taxes {
              amount {
                value
              }
              title
              rate
            }
          }
          discounts {
            amount {
              value
              currency
            }
            label
          }
        }
      }
    }
  }
}
''';

var getRegionData =  ''' 
query {
    country(id: "IN") {
        id
        two_letter_abbreviation
        three_letter_abbreviation
        full_name_locale
        full_name_english
        available_regions {
            id
            code
            name
        }
    }
}
''';

var getListOfAddress =  ''' 
query {
    customer {
    firstname
    lastname
    suffix
    email
    addresses {
    id
         default_shipping
      default_billing
      firstname
      lastname
      street
      city
      region {
        region_code
        region
      }
      postcode
      country_code
      telephone
    }
  }
}
''';

var getWishList =  ''' 
{
  wishlist {
    items_count
    name
    sharing_code
    updated_at
    items {
      id
      qty
      description
      added_at
      product {
        sku
        name
         small_image{
          url
          label
      }
price_range {
        minimum_price {
          regular_price {
            value
            currency
          }
          final_price {
            value
            currency
          }
          discount {
            amount_off
            percent_off
          }
        
        }
      }
      }
    }
  }
}
''';

var searchProduct =  ''' 
query products(\$search: String!){
  products(search: \$search) {
    total_count
    items {
      name
      sku
      special_price
    }
    page_info {
      page_size
      current_page
    }
  }
}
''';


var getFilterData =  ''' 
query products(\$filter: ProductAttributeFilterInput){
  products(filter: \$filter) {
    total_count
    aggregations{
      attribute_code
      label
      count
      options{
        count
        label
        value
      }
    }
}
}
''';