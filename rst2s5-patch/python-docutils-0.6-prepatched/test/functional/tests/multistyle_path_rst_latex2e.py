# Source and destination file names.
test_source = "simple.txt"
test_destination = "multistyle_path_rst_latex2e.tex"

# Keyword parameters passed to publish_file.
reader_name = "standalone"
parser_name = "rst"
writer_name = "latex2e"

# Settings
settings_overrides['stylesheet'] = ''
settings_overrides['stylesheet_path'] = 'data/spam,data/ham.tex'
settings_overrides['embed_stylesheet'] = 0
