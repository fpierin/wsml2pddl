package br.usp.each.wsml2pddl.sistema.impl;

import java.io.File;

import org.antlr.runtime.ANTLRFileStream;
import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.TokenStream;
import org.antlr.runtime.tree.CommonTreeNodeStream;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;
import br.usp.each.wsml2pddl.gramaticas.GramaticaWSMLLexer;
import br.usp.each.wsml2pddl.gramaticas.GramaticaWSMLParser;
import br.usp.each.wsml2pddl.gramaticas.TradutorWSML2PDDL;
import br.usp.each.wsml2pddl.sistema.Compilador;

/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class CompiladorWsmlPDDL implements Compilador {

	@Override
	public String compila(final File arquivo) {
		try {
			final CharStream charStream = new ANTLRFileStream(arquivo.getPath());
			final GramaticaWSMLLexer gramaticaWSMLLexer = new GramaticaWSMLLexer(charStream);
			final TokenStream tokenStream = new CommonTokenStream(gramaticaWSMLLexer);
			final GramaticaWSMLParser wsmlParser = new GramaticaWSMLParser(tokenStream);
			
			final CommonTreeNodeStream nodeStream = new CommonTreeNodeStream(wsmlParser.wsml().getTree());
			final TradutorWSML2PDDL tradutor =  new TradutorWSML2PDDL(nodeStream);
			final Avaliador avaliador = tradutor.avaliador();
			return avaliador.avalia();
			
		} catch (final Exception e) {
			return e.getMessage();
		}
	}

	@Override
	public String compila(final String cadeiaDePalavras) {
		try {
			final CharStream charStream = new ANTLRStringStream(cadeiaDePalavras);
			final GramaticaWSMLLexer gramaticaWSMLLexer = new GramaticaWSMLLexer(charStream);
			final TokenStream tokenStream = new CommonTokenStream(gramaticaWSMLLexer);
			final GramaticaWSMLParser wsmlParser = new GramaticaWSMLParser(tokenStream);
			
			final CommonTreeNodeStream nodeStream = new CommonTreeNodeStream(wsmlParser.wsml().getTree());
			final TradutorWSML2PDDL tradutor =  new TradutorWSML2PDDL(nodeStream);
			final Avaliador avaliador = tradutor.avaliador();
			return avaliador.avalia();
			
		} catch (final Exception e) {
			return e.getMessage();
		}
	}
	
	

}
