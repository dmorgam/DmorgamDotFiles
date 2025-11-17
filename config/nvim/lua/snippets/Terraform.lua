-- Snippets para Terraform

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("terraform", {

    -- Basicos --------------------------------------------------

    -- Variables

    s('variable', {
        t('variable "'), i(1, 'var_name'), t('" {'),
        t({'','  type        = '}), i(2, 'string'),
        t({'','  description = "'}), i(3, 'Description'), t('"'),
        t({'','  default     = "'}), i(4, 'def_value'), t('"'),
        t({'','}'})
    }),

    s('variable map(obj)', {
        t('variable "'), i(1, 'var_name'), t('" {'),
        t({'','  description = "'}), i(2, 'Description'), t('"'),
        t({'',''}),
        t({'','  type = map(object({'}),
        t({'','    '}), i(3, 'key1'), t(' = '), i(4, 'string'),
        t({'','    '}), i(5, 'key2'), t(' = '), i(6, 'number'),
        t({'','  }))'}),
        t({'','}'})
    }),

    s('locals', {
        t('locals {'),
        t({'','  '}), i(1, 'name'), t(' = "'), i(2, 'value'), t('"'),
        t({'','}'})
    }),

    -- Terraform
    s('terraform', {
        t('terraform {'),
        t({'','  required_version = "'}), i(1, '>= 1.13.0'), t('"'),
        t({'',''}),
        t({'','  required_providers {'}),
        t({'','    '}), i(2, 'aws'), t(' = {'),
        t({'','      source  = "'}), i(3, 'hashicorp/aws'), t('"'),
        t({'','      version = "'}), i(4, '~> 6.20.0'), t('"'),
        t({'','    }'}),
        t({'','  }'}),
        t({'','}'})
    }),

    -- Backend
    s('backend', {
        t('backend "'), i(1, 's3'), t('" {'),
        t({'','  bucket = "'}), i(2, 'bucket-name'), t('"'),
        t({'','  key    = "'}), i(3, 'tf-state'), t('"'),
        t({'','  region = "'}), i(4, 'eu-central-1'), t('"'),
        t({'','}'})
    }),

    -- Providers
    s('provider', {
        t('provider "'), i(1, 'aws'), t('" {'),
        t({'','  region = "'}), i(2, 'eu-central-1'), t('"'),
        t({'','}'})
    })

})
