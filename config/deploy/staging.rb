server "ec2-107-23-183-117.compute-1.amazonaws.com", user: "deploy", roles: %w{app db web}
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp