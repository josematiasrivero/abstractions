package com.abstractions.service.core;

public class NullKeyProvider implements KeyProvider {

	@Override
	public String apply(String value) {
		return value;
	}
}
