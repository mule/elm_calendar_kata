module.exports = {
    // See http://brunch.io for documentation.
    files: {
        javascripts: {
            joinTo: 'app.js'
        },
        stylesheets: {
            joinTo: 'app.css'
        },
        templates: {
            joinTo: 'app.js'
        }
    },

    paths: {
        watched: [
            "app/",
            "app/assets",
            "app/js",
            "app/elm/calendar.elm"
        ]
    },
    plugins: {
        elmBrunch: {
            // Set to path where elm-package.json is located, defaults to project root (optional)
            // if your elm files are not in /app then make sure to configure paths.watched in main brunch config
            elmFolder: 'app/elm',

            // Set to the elm file(s) containing your "main" function
            // `elm make` handles all elm dependencies (required)
            // relative to `elmFolder`
            mainModules: ['calendar.elm'],

            // Defaults to 'js/' folder in paths.public (optional)
            outputFolder: '../js/vendor/',

            // optional: add some parameters that are passed to elm-make
            makeParameters: ['--warn']
        },
        babel: {
             ignore: [/js\/vendor/]


        }
    },
    npm: {
        enabled: true,
        // Whitelist the npm deps to be pulled in as front-end assets.
        // All other deps in package.json will be excluded from the bundle.
        whitelist: ["materialize-css"],
        styles: {
            "materialize-css": ['/bin/materialize.css']
        }
    }

}
