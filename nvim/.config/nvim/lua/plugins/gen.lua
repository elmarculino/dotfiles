return {
  'David-Kunz/gen.nvim',
  keys = {
    { '<leader>G', mode = { 'n', 'x' }, ':Gen<CR>', desc = 'Gen AI+' },
  },
  config = function()
    local format = [[\nOutput the result in the format ```$filetype\n...\n```.]]
    local code = [[\nIf I didn't provide code, say so briefly and don't give additional advice.\n```$filetype\n$text\n```]]

    require('gen').setup {
      model = 'dolphin-llama3:8b-v2.9-q5_K_M', -- The default model to use.
      host = 'localhost', -- The host running the Ollama service.
      port = '11434', -- The port on which the Ollama service is listening.
      display_mode = 'split',
      show_prompt = true,
      prompts = {
        -- Interactive
        Chat = { prompt = '$input' },
        Ask = { prompt = '$input\n$text' },

        -- Generate code
        ['Fix code'] = { prompt = 'Fix the following code' .. format .. code },
        ['Optimize code'] = { prompt = 'Optimize and simplify the following code.' .. format .. code },
        ['Generate doc comment'] = { prompt = 'Generate a doc comment for the following code and stop once the comment is complete.' .. format .. code },
        ['Generate tests'] = {
          prompt = 'Generate unit tests for the following code. Write short to-the-point test methods with only one or two asserts each.' .. format .. code,
        },

        -- Talk about code
        ['Review code'] = { prompt = 'Review the following code and make concise suggestions. Give extra weight to bugs.' .. code },
        ['Explain code'] = { prompt = 'Explain the following code.' .. code },
        ['Analyse code readability'] = { prompt = 'Analyse the readability of the following code.' .. code },
      },
    }
  end,
  --  config = function (_, opts)
  --    -- require('gen').model = 'mistal:instruct'
  --    -- require('gen').command = 'ollama run $model "$prompt"'
  --    require('gen').prompts =
  --    {
  --      Elaborate_Text =
  --        {
  --          prompt = "Elaborate the following text:\n$text",
  --          replace = true
  --        },
  --      Fix_Code =
  --        {
  --          prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
  --          replace = true,
  --          extract = "```$filetype\n(.-)```"
  --        },
  --      Generate_Google_Docstring =
  --        {
  --          prompt = "Generate a PT-BR Google Docstring in ```$filetype\n...\n``` format for the following source code:\n```$filetype\n$text\n```",
  --          replace = true,
  --          extract = "```$filetype\n(.-)```"
  --        }
  --    }
  --  end
}
