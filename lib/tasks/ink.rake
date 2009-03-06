namespace :ink do
	desc "Setup basic needs so that our app runs."
	task :setup do
		# Hmm… I was going to have this copy the environment.rb and database.yml files,
		# but it appears that you need working environment.rb and, possibly, database.yml files
		# in order to run rake tasks, since they load up with your environment. Yaysies!
		puts "Please run script/ink/install if you haven't already, and follow the instructions there."
		puts "Or just look at the bloody README file, for Pete's sake!"
	end
end
