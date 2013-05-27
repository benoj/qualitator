require 'git_repository'

task :default => [:run_tests,:git]
task :git do
	git = GitRepository.new
	git.pull
	if(git.has_untracked?)
		git.add
	end
	if(git.has_changes?)
		git.commit(:message => ENV["m"])
	end
	git.push
end

task :run_tests do
	Dir.glob("test/*.rb") do |file|
		sh "ruby '#{file}'"
	end
end
