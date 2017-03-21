## Universal Form Test Application
This application is meant as a test application to develop the features that will eventually be made into the Universal Form gem. The gem, and the test application in general, is built to generate forms automatically for all necessary attributes of a Model for building a simple CRUD. The model methods included in application_record.rb are exposed to each model. Some of the methods are built to be overwritten by a user, and some have been built that aren't meant for that purpose.

The form helpers are built using form_for syntax, and will generate new form fields of appropriate types based on the data-type of each non-exluded attribute.
## Supported Data Types
* Integer
* Float
* Decimal (requires precision and scale)
* Boolean
* String
* Text
* Time
* Date
* DateTime
* ActiveRecord Associations also Supported
Anything not listed above is not currently supported by the application.
## Specifications
This application will is run using Rails 5.0 and Ruby 2.3.1. Rails 4 is unsupported by the application due to the need to add the methods to the application_record.rb file.
This application uses JavaScript to limit inputs into different fields based on their configuration.
## Use
This application uses form_for to develop partials for your use. To render a partial,
``