package br.usp.each.wsml2pddl.gramaticas;

import java.io.IOException;

import org.antlr.runtime.ANTLRFileStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.TokenStream;
import org.antlr.runtime.tree.CommonTreeNodeStream;

import br.usp.each.wsml2pddl.evaluators.Evaluator;

public class Compilador {

	public static void main(final String[] args) throws RecognitionException, IOException {
		
		final CharStream charStream = new ANTLRFileStream("src/main/java/goal.wsml");
		final WsmlLexer lexer = new WsmlLexer(charStream);
		final TokenStream tokenStream = new CommonTokenStream(lexer);
		final WsmlParser wsmlParser = new WsmlParser(tokenStream);
		
//		final evaluator_return evaluator = wsmlParser.evaluator();
//		System.out.println(evaluator.tree.toStringTree());

		
		final CommonTreeNodeStream nodeStream = new CommonTreeNodeStream(wsmlParser.wsml().tree);
		final ProblemTranslator walker =  new ProblemTranslator(nodeStream);
		final Evaluator wsml = walker.evaluator();
		System.out.println(wsml.evaluate()); 
//		System.out.println(result.evaluate());
//		
//		final Sample3Lexer lexer = new Sample3Lexer(stream);
//		final TokenStream tokenStream = new CommonTokenStream(lexer);
//		final Sample3Parser parser = new Sample3Parser(tokenStream);
//		final Evaluator evaluator = parser.evaluator();
//		System.out.println("ok - result is " + evaluator.evaluate());		
//		
//		CommonTreeNodeStream nodeStream = new CommonTreeNodeStream(evaluator.tree);
//		EvaluatorWalker walker =  new EvaluatorWalker(nodeStream);
//		int result = walker.evaluator();
//		System.out.println("ok - result " + result);		
	}

}
