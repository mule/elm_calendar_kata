var testContext = require.context('../app/', true, /^((?![\\/]elm-stuff[\\/]).)*\.js$/);
testContext.keys().forEach(testContext)
