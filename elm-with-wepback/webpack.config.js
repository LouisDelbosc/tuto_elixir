var path = require('path');

module.exports = {
  entry: {
    app:[
      './src/index.js'
    ]
  },

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: '[name].js'
  },

  module: {
    loaders: [
      {test: /\.(css|scss)$/, loaders: ['style-loader', 'css-loader']},
      {test: /\.html$/, loader: 'file?name=[name].[ext]',
       exclude: /node_modules/},
      {test: /\.elm$/, loader: 'elm-webpack',
       exclude: [/elm-stuff/, /node_modules/]},
      {test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader?limit=10000&minetype=application/font-woff'},
      {test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: 'file-loader'},
    ],

    noParse: /\.elm$/
  },

  devServer: {
    inline: true,
    stats: { colors:true }
  }
};
