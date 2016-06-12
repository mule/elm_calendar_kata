module.exports = {
    module: {
        loaders: [{
            test: /\.js?$/,
            exclude: /(node_modules|bower_components|elm-stuff)/,
            loader: 'babel',
            query: {
                presets: ['es2015']
            }
        }]
    },
    devtool: 'source-map'
}
