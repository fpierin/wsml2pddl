grammar Sample;

options {
  language = Java;
}

@header {
  package br.usp.each.wsmo2pddl;
}

@lexer::header {
  package br.usp.each.wsmo2pddl;
}

rule: IDENT ;

IDENT : 'a'..'z'+;

