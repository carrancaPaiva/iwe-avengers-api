package com.iwe.avengers.dao;

import java.util.Map;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.repository.DynamoDBManager;

public class AvengerDAO {
	
	
	private static final DynamoDBMapper mapper  = DynamoDBManager.mapper();
	
	
	public Avenger search(String id) {
		return mapper.load(Avenger.class,id);
	}


	
	public Avenger save(Avenger avenger) {

		mapper.save(avenger);
		return avenger;

	}


	public void remove(Avenger avenger) {
		mapper.delete(avenger);
	}

	
}
