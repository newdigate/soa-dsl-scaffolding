package com.newdigate.soa.entitydsl.tests

import com.google.inject.Injector
import com.newdigate.soa.entitydsl.EntityLanguageStandaloneSetup
import com.newdigate.soa.entitydsl.entityLanguage.Entity
import com.newdigate.soa.entitydsl.entityLanguage.EntityPackageDeclaration
import org.eclipse.emf.common.util.URI
import org.eclipse.xtext.resource.XtextResourceSet
import org.eclipse.xtext.util.StringInputStream
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test

public class DBTests {			

	var Injector injector;
	
	@Before
	def void setup() {
		injector = new EntityLanguageStandaloneSetup().createInjectorAndDoEMFRegistration();
	}

	@After
	def void after() {
	}
	
	@Test
    def void testBasicPackage() {   	  	
    	val packageSrc = 
'''package com.newdigate.users {
entity user {
}
}'''		
		val resourceSet = injector.getInstance(XtextResourceSet)
		val resource = resourceSet.createResource(URI.createURI("/src/one.entityspec"))
		resource.load(new StringInputStream(packageSrc), #{})
		val x = resource.contents.get(0) as EntityPackageDeclaration
		Assert::assertEquals("com.newdigate.users", x.name);
		Assert::assertNotNull(x.elements);
		Assert::assertEquals(1, x.elements.length);
		Assert::assertNotNull(x.elements.get(0));
		Assert::assertTrue(x.elements.get(0) instanceof Entity);
		Assert::assertEquals("user", (x.elements.get(0) as Entity).name);
    }				
}