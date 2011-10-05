package br.usp.each.wsml2pddl.sistema;

import java.io.IOException;

import org.antlr.runtime.ANTLRFileStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.TokenStream;
import org.antlr.runtime.tree.CommonTreeNodeStream;

import br.usp.each.wsml2pddl.gramaticas.GramaticaWSMLLexer;
import br.usp.each.wsml2pddl.gramaticas.GramaticaWSMLParser;
import br.usp.each.wsml2pddl.gramaticas.TradutorDeProblemaPDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class Compilador {

	public static void main(final String[] args) throws RecognitionException, IOException {
		
		final CharStream charStream = new ANTLRFileStream("src/main/java/goal.wsml");
		final GramaticaWSMLLexer gramaticaWSMLLexer = new GramaticaWSMLLexer(charStream);
		final TokenStream tokenStream = new CommonTokenStream(gramaticaWSMLLexer);
		final GramaticaWSMLParser wsmlParser = new GramaticaWSMLParser(tokenStream);
		
		final CommonTreeNodeStream nodeStream = new CommonTreeNodeStream(wsmlParser.wsml().getTree());
		final TradutorDeProblemaPDDL tradutorDeProblemaPDDL =  new TradutorDeProblemaPDDL(nodeStream);
		final Avaliador avaliador = tradutorDeProblemaPDDL.avaliador();
		System.out.println(avaliador.avalia()); 
		
	}

}
