return {
 "David-Kunz/gen.nvim",
  keys = {
    { "<leader>G", mode = { "n", "x" }, ":Gen<CR>", desc = "Gen AI+" },
  },
  config = function()
      require('gen').model = 'dolphin2.2-mistral'
      -- require('gen').command = 'HOME=$HOME/.local/xdg-garbage ollama run $model $prompt'
      local coding_model = "codellama:13b-instruct"
      local coding_python_model = "codellama:13b-python"
      
      local prompts = require("gen").prompts
    
      prompts["Explain"] = { prompt = "Explain the following text:\n$text" }
      prompts["Code_Change"] = {
        prompt = "Below is an instruction that describes a task. Write a response that appropriately completes the request.\n\n### Instruction:\n$input\n[CODE]\n$text\n[/CODE]\n" .. "\n\n### Response:",
        replace = false,
        extract = "```$filetype\n(.-)```",
        model = coding_model,
      }
      prompts["Code_Enhance"] = {
        prompt = "Enhance the following code, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```",
        model = coding_model,
      }
      prompts["Code_Review"] = {
        prompt = "Review the following code and make concise suggestions:\n```$filetype\n$text\n```",
        model = coding_model,
      }
      prompts["Code_Generate"] = {
        prompt = "You are an expert programmer that writes simple, concise and efficient code. $input",
        replace = true,
        model = coding_model,
      }
      prompts["Code_Complete_Python"] = {
        prompt = "$text",
        replace = true,
        model = "codellama:13b-code",
      }
      prompts["Code_Explain_Python"] = {
        prompt = "Review the following python code:\n```$text\n```",
        replace = false,
        model = "codellama:13b-python",
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
