module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    meta:
      file   : 'TaKo'
      assets : "assets",
      package : "package",
      temp   : "build",
      banner : """
        /* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("m/d/yyyy") %>
           <%= pkg.homepage %>
           Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %> - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */

        """
    # =========================================================================
    source:
      coffee: [
            "src/**.coffee",
            "src/elements/**.coffee",
            "src/modules/**.coffee"
          ]

      stylus:[
        "stylesheets/TaKo.base.styl",
        "stylesheets/TaKo.section.styl",
        "stylesheets/TaKo.lists.styl",
        "stylesheets/TaKo.forms.styl",
        "stylesheets/TaKo.layouts.styl",
        "stylesheets/TaKo.loader.styl",
        "stylesheets/TaKo.buttons.styl",
        "stylesheets/TaKo.notifications.styl",
        "stylesheets/TaKo.colors.styl",
        "stylesheets/TaKo.icons.styl"
      ]
      theme: [
        "stylesheets/TaKo.theme.styl"
      ],

      components: [
        "components/zepto/zepto.js",
        "components/hammer/hammer.js",
        "components/hammer/jquery.hammer.js"
      ]


    # =========================================================================
    coffee:
      core: files: '<%=meta.temp%>/<%=meta.file%>.debug.js': '<%= source.coffee %>'
      core_debug: files: '<%=meta.package%>/js/<%=meta.file%>.debug.js': '<%= source.coffee %>'

    concat:
      components:
        src: "<%= source.components %>",  dest: "<%=meta.temp%>/js/<%=meta.file%>.components.js"

    uglify:
      options: compress: false, banner: "<%= meta.banner %>"
      components: files: '<%=meta.package%>/js/<%=meta.file%>.components.js': '<%=meta.temp%>/js/<%=meta.file%>.components.js'
      engine: files: '<%=meta.package%>/js/<%=meta.file%>.js': '<%=meta.temp%>/<%=meta.file%>.debug.js'

    stylus:
      core:
        options: compress: true, import: [ 'TaKo.constants']
        files: '<%=meta.package%>/stylesheets/<%=meta.file%>.css': '<%=source.stylus%>'
      theme:
        options: compress: true, import: [ 'TaKo.constants']
        files: '<%=meta.package%>/stylesheets/<%=meta.file%>.theme.css': '<%=source.theme%>'

    watch:
      coffee:
        files: ["<%= source.coffee %>"]
        tasks: ["coffee:core", "coffee:core_debug", "uglify:engine"]
      stylus:
        files: ["<%= source.stylus %>"]
        tasks: ["stylus:core"]
      theme:
        files: ["<%= source.theme %>"]
        tasks: ["stylus:theme"]

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-watch"

  grunt.registerTask "default", [ "coffee", "concat", "uglify", "stylus", "concat"]