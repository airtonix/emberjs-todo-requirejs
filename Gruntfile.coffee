module.exports = (grunt) ->

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)
  require('matchdep').filter('grunt-*').forEach(grunt.loadNpmTasks)
  path = require("path")

  @paths =
    build: "./build"
    dist: "./dist"
    src: "./src"

  images_regex = /(img\/[\w\d-]*\.(png|jpg|jpeg|gif))/
  api_regex = /(api\/.*\/[\w\d-]*\.json)/
  fonts_regex = /(fonts\/[\w\d-]*\.(eot|ttf|otf|woff|svg))/
  scripts_regex = /(js\/[\w\d-]*\.js)/


  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'
    bower: grunt.file.readJSON 'bower.json'

    paths: @paths

    coffee:
      build:
        options:
          sourceMap: true
          sourceMapDir: '<%= paths.build %>/static/maps/'
        files: [
          expand: true
          cwd: '<%= paths.src %>/client/js'
          src: '**/*.coffee'
          dest: '<%= paths.build %>/static/js'
          ext: '.js'
        ]

    sass:
      options:
        includePaths: [
          'bower_components/ratchet/sass/'
          'bower_components/bourbon/app/assets/stylesheets/'
          '<%= paths.src %>/client/'
        ]
      build:
        files: {
          "<%= paths.build %>/static/css/screen.css": "<%= paths.src %>/client/css/screen.scss"
        }

    copy:
      build:
        files: [
          expand: true
          cwd: '<%= paths.src %>/client'
          dest: '<%= paths.build %>/static'
          src: [
            'img/**/*.{jpg,jpeg,gif,png,webp}'
            'fonts/**/*.{ttf,eot,otf,woff,svg}'
          ]
        ]

      dist:
        files: [
          expand: true
          cwd: '<%= paths.build %>/static'
          dest: '<%= paths.dist %>/static'
          src: [
            '**/*.css'
            '**/*.js'
            '**/*.{jpg,jpeg,gif,png,webp}'
            '**/*.{ttf,eot,otf,woff,svg}'
          ]
        ]

    jade:
      build:
        files: [
          expand: true
          cwd: '<%= paths.src %>/client/js'
          dest: '<%= paths.build %>/static/js'
          ext: '.tpl.html'
          src: [
            '**/*.jade'
          ]
        ]

    html2js:
      options:
        module: "app.templates"
        indentString: ''
        htmlmin:
          collapseWhitespace: true

      dist:
        options:
          base: "<%= paths.build %>/static/"
          rename: (name) ->
            '/' + name
        src: ['<%= paths.build %>/static/js/**/templates/**/*.html']
        dest: '<%= paths.build %>/static/js/templates.js'

    requirejs:
      options:
        wrap: true
        almond: true
        preserveLicenseComments: false
        mainConfigFile: "<%= paths.build %>/static/js/boot.js"
        name: 'boot'
        urlArgs: 'v=<%= pkg.version %>'
        out: "<%= paths.dist %>/static/js/application.js"

      test:
        options:
          optimize: "none"

      dist:
        options:
          optimize: "uglify"

    filerev:
      options:
        encoding: 'utf8'
        algorithm: 'md5'
        length: 8
        copy: false

      build:
        files: [
          expand: true
          cwd: '<%= paths.build %>/static'
          dest: '<%= paths.dist %>/static'
          src: [
            'js/**/*.js'
            'js/**/*.html'
             'img/**/*.{jpg,jpeg,gif,png,webp}'
           'css/**/*.css'
            'fonts/**/*.{ttf,eot,otf,woff,svg}'
            'api/**/*.json'
          ]
        ]

    userev:
      options:
        hash: /([a-f0-9]{8})\.[a-z]+$/

      application:
        src: '<%= paths.dist %>/static/js/**/*.js'
        options:
          patterns:
            'Data': api_regex
            'Images': images_regex

      styles:
        src: '<%= paths.dist %>/static/css/**/*.css'
        options:
          patterns:
            'Images': images_regex
            'Fonts': fonts_regex

      views:
        src: '<%= paths.dist %>/static/**/*.html'
        options:
          patterns:
            'Scripts': scripts_regex
            'Images': images_regex

    clean:
      build:
        src: ["<%= paths.build %>"]

      dist:
        src: ["<%= paths.dist %>"]

    bump:
      options:
        files: ['package.json', 'bower.json']
        updateConfigs: ['pkg', 'bower']
        createTag: true
        commit: true
        push: true

      develop:
        options:
          pushTo: 'origin develop'

      heroku:
        options:
          pushTo: 'heroku master'

    jsdoc:
      options:
        src: [
          'src/**/**.js'
          'src/**/**.coffee'
        ]
        destination: 'doc'

    karma:
      options:
        configFile: "<%= paths.src %>/tests/config.json"

        preprocessors:
          '<%= paths.src %>/**/*.coffee': ['coffee']

        coffeePreprocessor:
          options:
            bare: true
            sourceMap: false
            transformPath: (path) ->
              path.replace /\.coffee$/, '.js'

      continuous:
        options:
          autoWatch: true

      single:
        options:
          singleRun: true
          autoWatch: false

    serve:
      dev:
        watch: true
        async: true 
      test:
        watch: false
          
  grunt.registerMultiTask "serve", "loads the server", () ->
    server = require './src/server'

  grunt.registerTask 'default', [
    'serve:dev'
  ]

  grunt.registerTask 'build', [
    'clean'
    'copy:build'
    'coffee:build'
    'sass:build'
    'jade:build'
  ]

  grunt.registerTask 'dist', [
    'build'
    'html2js:dist'
    'requirejs:dist'
    'filerev:dist'
    'userev:dist'
    'copy:dist'
    'clean:build'
  ]
  
  grunt.registerTask 'deploy', [
    'dist'
    'bump:heroku'
  ]

  grunt.registerTask 'test', [
    'build'
    'serve:test'
  ]