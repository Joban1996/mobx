







var loginOtpVerify = '''query loginOTPVerify(\$mobileNumber: String!,\$otp: String!,\$websiteId: Int!){ 
loginOTPVerify(mobileNumber: \$mobileNumber,otp: \$otp,websiteId: \$websiteId){
    message
    status
    token
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

var generateCartId =  '''query customerCart{ 
  customerCart{
    id
    items {
      id
      product {
        name
        sku
      }
      quantity
    }
  }
}
''';