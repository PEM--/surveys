@lightLoginSchema = new SimpleSchema
  email:
    type: String
    regEx: SimpleSchema.RegEx.Email
  password:
    type: String
    min: 6
    max: 20
