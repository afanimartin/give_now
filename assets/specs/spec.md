
## MVP
- [x] login with gmail
- [x] logout
- [x] preview images to be uploaded
- [x] add items to cart
- [x] add metadata to item before upload. update title, description, etc
- [x] style title, description fields with all border
- [x] display title of item instead of price and shopping_bag_outlined icon
- [x] render items in the marketplace that don't belong to the current user
- [x] remove items from cart
- [x] show how many items have been added to cart
- [x] update login screen design with primary color background
- [x] user should be able to edit/delete items uploaded by them. add menu button on the appbar with delete/donate options if the user uploaded the item
- [x] checkout items from the cart
- [x] add buttons for deleting/donating item
- [x] delete item uploaded by current user
- [x] donate item uploaded by current user
- [x] change valueColor of progress_loader to primaryColorDark
- [x] refactor code, make it more readable and maintainable
- [] add unit tests for core logic
- [] validate form inputs
- [] create new logo, update icon and name of app to [samaria]
- [] pass user phone to custom claims [id token]
- [] invite users for testing
- [] learn more about security rules and how to properly implement them of firestore

## After MVP
- [] link CI/CD with firebase app distribution and Google play store
- [] migrate app to null safety
- [] add onboarding screens. checkout [flow_builder]
- [] add dark theme
- [] add snackbar to show item was added or donated
- [] show user item is being uploaded
- [] resize images before uploading to storage to save space and money
- [] remove item from cart when deleted by the owner
- [] render progress loader when editing an item
- [] only show floatingActionButton when item being edited is dirty
- [] render appBar in a SingleChildScrollView widget
- [] show login progress when contacting google servers
- [] handle exceptions and properly validate input values
- [] add terms and conditions
- [] allow user to input quantity of product
- [] only render item available in stock in carts, else inform user the cart item is no longer available. use a snackbar [loop through list of items in stock, decrement quantity of given item in db accordingly]
- [] render main image along side other images of an item
- [] filter items based on category
- [] add localization to the app [ENG(US) & ARABIC(SUDAN)]
- [] view/edit profile - edit display_name and phone_number
- [] show snackbar when item added successfully to cart
- [] remove image(s) during preview
- [] implement infinite scrolling for marketplace items
- [] hide/disable floating action button on the marketplace screen
- [] render dropdownButton items within the widget itself
- [] add user reviews
- [] user should not be able to add item already in cart. show check icon for items in cart
- [] implement international phone number input

## CURRENT BUGS
- [x] fix bug with loading cart items
- [] bottom navigator not rendering always
- [x] list of cart items is not scrolling
- [] fix bug with cancelling image selection
- [] logging out: `Invalid argument(s): No host specified in URI`
- [] renderFlex overflowed by 52 pixels on the bottom. on edit item screen
- [] new user is getting created everytime the same user signs in

