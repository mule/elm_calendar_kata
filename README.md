# Elm calendar kata

A simple calendar app I am making to practice Elm.

* Intentionally used momentjs instead of Elm native Date package to practice use of ports and whatnot.
* Materialize-css and sass used for layout
* Brunch as a build tool
* Karma + webpack to run tests. No Elm tests yet though. :-(

## Getting started
* Install (if you don't have them):
    * [Node.js](http://nodejs.org): `brew install node` on OS X
    * [Brunch](http://brunch.io): `npm install -g brunch`
    * [Elm](http://elm-lang.org): `npm install -g elm`
    * [Karma] (https://karma-runner.github.io): `npm install -g karma`
    * Brunch plugins and app dependencies: `npm install`
* Run:
    * `brunch watch --server` — watches the project with continuous rebuild. This will also launch HTTP server with [pushState](https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Manipulating_the_browser_history).
    * `brunch build --production` — builds minified project for production
* Tests: 
   * `karma start` - runs tests continously. 
* Learn:
    * `public/` dir is fully auto-generated and served by HTTP server.  Write your code in `app/` dir.
    * Place static files you want to be copied from `app/assets/` to `public/`.
    * [Brunch site](http://brunch.io), [Getting started guide](https://github.com/brunch/brunch-guide#readme)
