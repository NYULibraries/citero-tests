require 'citero-jruby'

formats = [["bibtex", ".bib"], ["easybib", ".json"], ["openurl", ".url"], ["refworks_tagged", ".ris"], ["ris", ".ris"]]
path = File.expand_path("../../pnx/*", __FILE__)

Dir.glob(path).each do |pnx_filepath|
  pnx_data = File.open(pnx_filepath){ |f| f.read }
  pnx_map = Citero.map(pnx_data).from_pnx
  formats.each do |to_format, extension|
    filename = pnx_filepath.gsub("/pnx/", "/#{to_format}/").gsub(".xml", "#{extension}")
    File.open(filename, "w") do |file|
      data = pnx_map.public_send(:"to_#{to_format}")
      file.write(data)
    end
  end
end
