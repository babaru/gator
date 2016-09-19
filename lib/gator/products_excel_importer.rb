
module Gator
  class ProductsExcelImporter
    class << self
      def parse(path)
        workbook = RubyXL::Parser.parse(path)
        result = []
        workbook.worksheets.each_with_index do |worksheet, w|
          break if w > 1
          sheet_name = worksheet.sheet_name
          sheet_data = []
          worksheet.each_with_index do |row, r|
            if r > 1
              row_data = []
              row && row.cells.each_with_index do |cell, c|
                val = cell && cell.value
                row_data << val
              end
              sheet_data << row_data
            end
          end

          result << { name: sheet_name, data: sheet_data }
        end
        result
      end

    end
  end
end
