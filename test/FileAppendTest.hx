import massive.munit.Assert;
import haxe.unit.TestRunner;

class FileAppendTest
{
	@BeforeClass
	public function setup()
	{
		TestUtils.createTempFolder();
	}
	
	@AfterClass
	public function tearDown()
	{
		TestUtils.removeTempFolder();
	}
	
	@Test
	public function simple_append_positive()
	{
		var filepath = TestUtils.getTmpFile();
				
		var txt = "hello world";
		
		xa.File.append(filepath, txt);
		
		Assert.isTrue(xa.File.read(filepath) == txt);
	}
	
	@Test
	public function simple_append_negative()
	{
		var filepath = TestUtils.getTmpFile();
				
		xa.File.append(filepath, "hello world");
		
		Assert.isFalse(xa.File.read(filepath) == "");
	}
	
	@Test
	public function line_breaks()
	{
		var filepath = TestUtils.getTmpFile();
		
		xa.File.append(filepath, "one\ntwo\nthree"); //FIXME: doubt this is cross-platform
		
		Assert.isTrue(xa.File.read(filepath).split("\n").length == 3);
	}
	
	@Test
	public function empty_path()
	{
		var result = false;
		
		try
		{
			xa.File.append("", "");
			result = true;
		}
		catch(e : Dynamic){}
		
		Assert.isFalse(result);
	}
	
	@Test
	public function null_path()
	{
		var result = true;
		
		try
		{
			xa.File.append(null, "");
			result = false;
		}
		catch(e : Dynamic){}
		
		Assert.isTrue(result);
	}
	
	@Test
	public function null_content()
	{
		var result = true;
		
		try
		{
			xa.File.append(TestUtils.getTmpFile(), null);
			result = false;
		}
		catch(e : Dynamic){}
		
		Assert.isTrue(result);
	}
}