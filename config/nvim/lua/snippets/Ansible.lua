-- Snippets para Python

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local ri = require("luasnip.extras").rep

ls.add_snippets("yaml", {

  -- Basicos --------------------------------------------------

  -- debug task
  s("ansible.builtin.debug", {
    t('- name: Debug variable '), i(1, 'debug-variable'),
    t({'','  ansible.builtin.debug:'}),
    t({'','    var: '}), ri(1),
    t({'','    verbosity: '}), i(2, '2'),
    t({''})
  }),

  -- template
  s("ansible.builtin.template", {
    t('- name: Template '), i(1, 'source/file.j2'), t(' to '), i(2, 'destination/file/name'),
    t({'','  ansible.builtin.template:'}),
    t({'','    src: '}), ri(1),
    t({'','    dest: '}), ri(2),
    t({'','    owner: '}), i(3, 'owner'),
    t({'','    group: '}), i(4, 'group'),
    t({'','    mode: "'}), i(5, '0644'), t('"'),
    t({''})
  }),

  -- copy file
  s("ansible.builtin.copy", {
    t('- name: Copy '), i(1, 'source/file/name'), t(' to '), i(2, 'destination/file/name'),
    t({'','  ansible.builtin.copy:'}),
    t({'','    src: '}), ri(1),
    t({'','    dest: '}), ri(2),
    t({'','    owner: '}), i(3, 'owner'),
    t({'','    group: '}), i(4, 'group'),
    t({'','    mode: "'}), i(5, '0644'), t('"'),
    t({''})
  }),

  -- file modes
  s("ansible.builtin.file", {
    t('- name: Change modes to file '), i(1, 'file/to/change'),
    t({'','  ansible.builtin.file:'}),
    t({'','    path: '}), ri(1),
    t({'','    owner: '}), i(2, 'owner'),
    t({'','    group: '}), i(3, 'group'),
    t({'','    mode: "'}), i(4, '0644'), t('"'),
    t({''})
  }),

  -- line in file
  s("ansible.builtin.lineinfile", {
    t('- name: Replace lines from '), i(1, 'file/to/change'), t(' that match '), i(2, '^regexp$'),
    t({'','  ansible.builtin.lineinfile:'}),
    t({'','    path: '}), ri(1),
    t({'','    regexp: '}), ri(2),
    t({'','    line: "'}), i(3, 'replacement_line'), t('"'),
    t({''})
  }),

  -- systemd service
  s("ansible.builtin.systemd_service", {
    t('- name: Ensure unit '), i(1, 'unit_name'), t(' is '), c(2, { t('reloaded'), t('restarted'), t('started'), t('stopped')}),
    t({'','  ansible.builtin.systemd_service:'}),
    t({'','    name: '}), ri(1),
    t({'','    state: '}), ri(2),
    t({'','    enabled: '}), c(3, { t('true'), t('false')}),
    t({''})
  }),

  -- include tasks
  s("ansible.builtin.include_tasks", {
    t('- name: Include tasks from '), i(1, 'tasks/file.yaml'),
    t({'','  ansible.builtin.include_tasks:'}),
    t({'','    file: '}), ri(1),
    t({''})
  }),

  -- ansible fail
  s("ansible.builtin.fail", {
    t('- name: Fail on condition '), i(1, 'condition_desc'),
    t({'','  ansible.builtin.fail:'}),
    t({'','    msg: "'}), i(2, "message"), t('"'),
    t({'','  when: '}), i(3, "condition"),
    t({''})
  }),

  -- ansible assert
  s("ansible.builtin.assert", {
    t('- name: Check some conditions'),
    t({'','  ansible.builtin.assert:'}),
    t({'','    that:'}),
    t({'','      - '}), i(1, "condition1"),
    t({'','      - '}), i(2, "condition2"),
    t({'','    fail_msg: "'}), i(3, "fail_message"), t('"'),
    t({'','    success_msg: "'}), i(4, "success_message"), t('"'),
    t({''})
  }),

})
