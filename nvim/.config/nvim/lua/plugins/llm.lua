return {
  'huggingface/llm.nvim',
  config = function()
    require('llm').setup {
      model = 'codellama/CodeLlama-13b-hf', --- also see "bigcode/starcoderplus", "bigcode/starcoder"
      query_params = {
        max_new_tokens = 100,
        temperature = 0.2, --- lower temperature to get more 'appropriate' output
        top_p = 0.8, --- lower top_p to get more suggestions
        stop_tokens = nil,
      },
      fim = {
        enabled = true,
        prefix = '<PRE> ', ---  "<fim_prefix>" for "codellama/CodeLlama-13b-hf", (the space matters)
        middle = ' <MID>', ---  "<fim_middle>" for "codellama/CodeLlama-13b-hf", (the space matters)
        suffix = ' <SUF>', ---  "<fim_suffix>" for "codellama/CodeLlama-13b-hf", (the space matters)
      },
      context_window = 4096, --- max number of tokens for the context window (max for "codellama/CodeLlama-13b-hf": 4096, max for "bigcode/starcoder: 8192)
      tokenizer = {
        repository = 'codellama/CodeLlama-13b-hf',
      },
      lsp = {
        bin_path = vim.api.nvim_call_function('stdpath', { 'data' }) .. '/mason/bin/llm-ls',
      },
      enable_suggestions_on_startup = false, -- do not enable by default
    }
  end,
}
