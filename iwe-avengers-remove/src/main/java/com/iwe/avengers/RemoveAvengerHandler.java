package com.iwe.avengers;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.response.HandlerResponse;
import com.iwe.avengers.dao.AvengerDAO;
import com.iwe.avengers.exception.AvengerNotFoundException;

public class RemoveAvengerHandler implements RequestHandler<Avenger, HandlerResponse> {
	private AvengerDAO dao = new AvengerDAO();

	@Override
	public HandlerResponse handleRequest(final Avenger removeAvenger, 
			final Context context) {

		context.getLogger().log("[#] - Remove Avenger");

		final Avenger searchAvenger = dao.search(removeAvenger.getId());
		
		if(!searchAvenger.getName().isEmpty() && 
			searchAvenger.getSecretIdentity().isEmpty()) {
			   throw new AvengerNotFoundException("[NotFound] - Avenger id: " + removeAvenger.getId());
		}

		dao.remove(searchAvenger);
		
	
		final HandlerResponse response = 
				HandlerResponse.builder()
				.build();

		context.getLogger().log("[#] - Removed Sucesso");
		
		return response;

	}
}
