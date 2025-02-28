-- Snippets para Python

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local ri = require("luasnip.extras").rep

ls.add_snippets("python", {

  -- Basicos --------------------------------------------------

  -- function
  s('def',{
    t('def '), i(1, 'fun_name'), t('('), i(2, 'param1'), t(': '), i(3, 'type1'), t(', '), i(4, 'param2'), t(': '), i(5, 'type2'),
                                 t(') -> '), i(6, 'return_type'), t(':'),
    t({'','    """'}),
    t({'','    '}), i(7, 'Description'),
    t({'',''}),
    t({'','    Args:'}),
    t({'','        '}), ri(2), t('('), ri(3),  t('): '), i(8, 'param1_desc'),
    t({'','        '}), ri(4), t('('), ri(5), t('): '), i(9, 'param2_desc'),
    t({'',''}),
    t({'','    Returns:'}),
    t({'','    '}), ri(6), t(': '), i(10, 'return_description'),
    t({'','    """'}),
    t({'','','    pass'})
  }),

  -- for
  s("for", {
    t('for '), i(1, "index"), t(' in '), i(2, "range"), t(':'),
    t({'','    pass'}),
  }),

  -- try
  s("try-except", {
    t('try:'),
    t({'','    '}), i(1, 'try_block'),
    t({'','except '}), i(2, 'exception_type'), t(' as e:'),
    t({'','    print(e, file=sys.stderr)'}),
    t({'','    exit(1)',''}),
  }),


  -- shebang
  s("#!-shebang", {
    t('#!/usr/bin/env python3'),
    t({'',''}),
    t({'','"""'}),
    t({'',''}), i(1, "Description"),
    t({'','"""'}),
    t({'',''}),
    t({'','import sys'}),
    t({'',''}),
    t({'',''}),
    t({'','if __name__ == "__main__":'}),
    t({'','    pass'}),
  }),


  -- Argparse -------------------------------------------------

  -- Parser argparse
  s("parser = argparse.ArgumentParser(", {
    t('parser = argparse.ArgumentParser('),
    t({'',''}), t('                    prog="'), i(1, 'ProgramName'), t('",'),
    t({'',''}), t('                    description="'), i(2, 'ProgramDescription'), t('",'),
    t({'',''}), t('                    epilog="'), i(3, 'TextAtTheBottom'), t('")'),
    t({'',''}),
  }),

  -- Argparse arguments
  s("parser.add_argument(positional)", {
    t('parser.add_argument("'), i(1, 'positional_argument'), t('", help="'), i(2, 'arg_description'), t({'")',''})
  }),

  s("parser.add_argument(option)", {
    t('parser.add_argument("-'), i(1, 'O'), t('", "--'), i(2, 'option'), t('", help="'), i(3, 'arg_description'), t({'")',''})
  }),

  s("parser.add_argument(on_off_flag)", {
    t('parser.add_argument("-'), i(1, 'f'), t('", "--'), i(2, 'flag'), t('", action="store_true", help="'), i(3, 'arg_description'), t({'")',''})
  }),


})
