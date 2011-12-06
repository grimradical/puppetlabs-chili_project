# Class: chili-project
#
# This module manages chili-project
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class chili_project(
  $gem_path='/var/lib/gems/1.8/bin',
  $version,
  $path,
  $configfile="$path/config/configuration.yml.example",
  $source_repo='git://github.com/chiliproject/chiliproject.git',
  $user='chili',
  $group='chili',
  $db_user='chili',
  $db_pass,
  $db_name='chili_project',
  $db_host='localhost',
  $db_port='3306',
  $load_default_data=true
) {
  Class[chili_project::step1] ->
  Class[chili_project::step2] ->
  Class[chili_project::step3] ->
  Class[chili_project::step4] ->
  Class[chili_project::step5] ->
  Class[chili_project::step6] ->
  Class[chili_project::step7]

  include chili_project::step1
  include chili_project::step2
  include chili_project::step3
  include chili_project::step4
  include chili_project::step5
  include chili_project::step6
  include chili_project::step7
}
