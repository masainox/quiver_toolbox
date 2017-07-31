def expects_path ; 'spec/fixtures/' ; end

def expect_content_json_file_01
  File.join(expects_path, 'expect_note_01.qvnote/content.json')
end


def expect_meta_json_file_01
  File.join(expects_path, 'expect_note_01.qvnote/meta.json')
end


def expect_notebook_meta_json_file_01
  File.join(expects_path, 'expect_notebook_01.qvnotebook/meta.json')
end
