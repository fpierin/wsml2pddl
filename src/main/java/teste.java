import java.util.HashMap;
import java.util.Map;

import br.usp.each.wsml2pddl.avaliadores.AvaliadorDeCondicao;
import br.usp.each.wsml2pddl.avaliadores.AvaliadorDeString;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;


public class teste {

	public static void main(String[] args) {
		
		final Map<String, String> mapa = new HashMap<String, String>();
		
		mapa.put("t1", "felipe");
		mapa.put("t2", "fernanda");
		
		String string = "==> $t1$ $t2$ ";
		
		Avaliador e = new AvaliadorDeString(string);
		e = new AvaliadorDeCondicao(e, "t0", "zero");
		for(String x: mapa.keySet()){
			e = new AvaliadorDeCondicao(e, x, mapa.get(x));
		}
		
		System.out.println(e.avalia());
		System.out.println("\n");		

	}

}
