
def valid_notebook_file_01; File.join(fixtures_path, 'valid_notebook_file_01_tutorial.qvnotebook') ; end

def valid_note_file_01
  File.join(valid_notebook_file_01, 'D2A1CC36-CC97-4701-A895-EFC98EF47026.qvnote')
end


def valid_note_file_02
  File.join(valid_notebook_file_01, 'ED3C96D1-AF37-4E66-9E6B-BB2005850479.qvnote')
end


def valid_note_hash_01
  {
    'created_at' => 1403566023,
    'tags' => ['tag1', 'tag2', 'tag3'],
    'title' => 'Valid Note Hash 01 Title',
    'updated_at' => 1443042305,
    'uuid' => 'D2A1CC36-CC97-4701-A895-EFC98EF47026',
    'cells' => valid_cells_01,
  }
end

def valid_cells_01
  [
    {
      'type' => 'text',
      'data' => 'Cell 01 data.'
    },

    {
      'type' => 'markdown',
      'data' => 'Cell 02 data.'
    },

    {
      'type' => 'text',
      'data' => 'Cell 03 data.'
    }
  ]
end


def valid_note_attributes_01
  {
    'uuid' => 'MYUUID',
    'type' => 'text',
    'notebook_path' => './spec/tmp/valid_note_attributes_01/',
    'tags'=> ['tag1', 'tag2', 'tag3']
  }
end

def valid_note_obj_01
  QuiverToolbox::Note.new do |n|
    n.created_at = 1403566023
    n.tags = ['tag1', 'tag2', 'tag3']
    n.title = 'My title'
    n.updated_at = ''
    n.updated_at = 1443042305
    n.uuid = 'D2A1CC36-CC97-4701-A895-EFC98EF47026'
    n.cells = valid_cells_01
    n.notebook_path = './spec/tmp/valid_note_obj_01/'
    n.file = File.join(tmp_path, 'note2.qvnote')
  end
end
