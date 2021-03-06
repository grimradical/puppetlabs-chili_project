class chili_project::database {
  exec { generate_session_store:
    command   => "which bundle && which gem && gem environment path && bundle exec rake generate_session_store",
    creates   => "${chili_project::path}/config/initializers/session_store.rb",
    path      => "${chili_project::gem_path}:/bin:/usr/bin:/usr/local/bin",
    cwd       => $chili_project::path,
  }
  ->
  exec { db_migrate:
    command     => "bundle exec rake db:migrate",
    creates     => "${chili_project::path}/db/schema.rb",
    path        => "${chili_project::gem_path}:/bin:/usr/bin:/usr/local/bin",
    cwd         => $chili_project::path,
    environment => 'RAILS_ENV=production',
  }

  if $chili_project::load_default_data {
    exec { load_default_data:
      command     => "bundle exec rake redmine:load_default_data",
      path        => "${chili_project::gem_path}:/bin:/usr/bin:/usr/local/bin",
      cwd         => $chili_project::path,
      environment => ['RAILS_ENV=production', 'REDMINE_LANG=en'],
      refreshonly => true,
      subscribe   => Exec[db_migrate],
    }
  }
}
