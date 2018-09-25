package com.iwe.avengers;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.response.HandlerResponse;
import com.iwe.avengers.dao.AvengerDAO;
import com.iwe.avengers.exception.AvengerNotFoundException;

public class SearchAvengersHandler implements RequestHandler<Avenger, HandlerResponse> {
	
	private AvengerDAO dao = new AvengerDAO();
	
	

	@Override
	public HandlerResponse handleRequest(final Avenger avenger, final Context context) {
		
		context.getLogger().log("[#] - Searching avenger by id: " + avenger.getId());
		
		
		
		final Avenger avengerFound  = dao.search(avenger.getId());
		
		if(avengerFound == null) {
            throw new AvengerNotFoundException("[NotFound] - Avenger id: "
                    + avenger.getId());
        }
		
		
		final HandlerResponse response  = HandlerResponse.builder().setObjectBody(avengerFound).build();
		
		context.getLogger().log("[#] - Avenger found!: " + avenger.getId());
		
		return response;
	}
}
