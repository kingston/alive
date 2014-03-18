module.exports = function(grunt) {
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		sass: {
			dist: {
				files: {
					'public/stylesheets/main.css' : 'app/stylesheets/main.scss'
				}
			}
		},
    exec: {
      compile: {
        command: 'cake build'
      }
    },
		watch: {
			css: {
				files: '**/*.scss',
				tasks: ['sass']
			},
      coffee: {
        files: '**/*.coffee',
        tasks: ['exec:compile']
      }
		}
	});
	grunt.loadNpmTasks('grunt-contrib-sass');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-exec')
};
