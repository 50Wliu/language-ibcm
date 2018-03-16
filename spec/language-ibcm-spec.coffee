describe "IBCM grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-ibcm")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.ibcm")

  it "parses the grammar", ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe "source.ibcm"

  it "tokenizes comments", ->
    {tokens} = grammar.tokenizeLine '2af3this is a comment!'
    expect(tokens[1]).toEqual value: 'this is a comment!', scopes: ['source.ibcm', 'comment.ibcm']

    {tokens} = grammar.tokenizeLine 'd37a  CS 2150'
    expect(tokens[1]).toEqual value: '  CS 2150', scopes: ['source.ibcm', 'comment.ibcm']

  it "tokenizes illegal instructions", ->
    {tokens} = grammar.tokenizeLine '2afg comment?'
    expect(tokens[1]).toEqual value: 'g comment?', scopes: ['source.ibcm', 'invalid.illegal.ibcm']

    {tokens} = grammar.tokenizeLine 'nope 3f9a'
    expect(tokens[0]).toEqual value: 'nope 3f9a', scopes: ['source.ibcm', 'invalid.illegal.ibcm']
