







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