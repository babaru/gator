namespace :products do
  task :import_from_excel, [:file_path] => :environment do |t, args|
    if defined?(Rails) && (Rails.env == 'development')
      Rails.logger = Logger.new(STDOUT)
    end

    result = Gator::ProductsExcelImporter.parse(args.file_path)
    Rails.logger.debug(result)
  end
end
