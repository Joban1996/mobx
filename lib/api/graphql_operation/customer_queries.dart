







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