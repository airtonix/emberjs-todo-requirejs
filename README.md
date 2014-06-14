# emberjs-todo-requirejs

My approach to learning EmberJs using: RequireJs, CoffeeScript, Jade, and a NodExt development server.

*abandoned due to bad documentation and inflexible modularity*

## What

Having been very familiar with AngularJs, I decided to grok EmberJs and get some perspective.

I started with this guide: 

 - http://emberjs.com/guides/getting-started/

The main goal here is to : 

 - Split application into modular sections with requirejs
 - Provide a simple restful backend with NodExt
 - Use Jade for html
 - Use Coffescript for JS
 - Use Scss for Styles


## Progress

- [ ] Static implementation of the EmberJs Getting Started Todo App
- [ ] Move fixtures into NodExt as Restful endpoints
- [ ] Convert styles to SCSS
- [ ] Make it easily deployable to Heroku

## Getting Started

- This assumes you have NodeJs installed.

```bash
$ npm install
$ npm setup
$ npm start
```


## Conclusion ?

Regarding Ember

- difficult to get modularised with RequireJs.
- getting started guide probably requires a very specific version.
- Feels like Backbone or Knockout. 

In short: A pain in the ass to scale.