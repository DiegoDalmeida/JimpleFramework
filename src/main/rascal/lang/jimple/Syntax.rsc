module lang::jimple::Syntax

alias Name = str;
alias Label = str;
alias Identifier = str; 

data Immediate 
 = local(str localName) 
 | intValue(int iValue)
 | floatValue(real fv)
 | stringValue(str sv)
 | nullValue(); 
 
public data ClassOrInterfaceDeclaration 
 = classDecl(Type typeName,
 	 list[Modifier] modifiers,
     Type superClass,
     list[Type] interfaces,
     list[Field] fields,
     list[Method] methods
   ) 
 | interfaceDecl(Type typeName,
     list[Modifier] modifiers, 
     list[Type] interfaces, 
     list[Field] fields,
     list[Method] methods
   );    
 

public data Field 
  = field(list[Modifier] modifiers, Type fieldType, Name name)
  ;  

public data Method 
  = method(list[Modifier] modifiers, Type returnType, Name name, list[Type] formals, list[Type] exceptions, MethodBody body)
  ;
  
      
data MethodBody 
  = methodBody(list[LocalVariableDeclaration] localVariableDecls, list[Statement] stmts, list[CatchClause] catchClauses)
  | signatureOnly()
  ; 

data LocalVariableDeclaration 
  = localVariableDeclaration(Type varType, Identifier local)
  ; 

data CatchClause 
 = catchClause(Type exception, Label from, Label to, Label with)
 ; 
 
data Variable 
 = localVariable(Name local)
 | arrayRef(Name reference, Immediate idx)
 | fieldRef(Name reference, FieldSignature field)
 | staticFieldRef(FieldSignature field)
 ;  
 
data Statement  
  = label(Label label)  
  | breakpoint()
  | enterMonitor(Immediate immediate)
  | exitMonitor(Immediate immediate)
  | tableSwitch(Immediate immediate, list[CaseStmt] stmts)
  | lookupSwitch(Immediate immediate, list[CaseStmt] stmts)
  | identity(Name local, Name identifier, Type idType)
  | identityNoType(Name local, Name identifier)
  | assign(Variable var, Expression expression)
  | ifStmt(Expression exp, GotoStmt stmt)
  | retEmptyStmt()
  | retStmt(Immediate immediate)
  | returnEmptyStmt() 
  | returnStmt(Immediate immediate)
  | throwStmt(Immediate immediate)
  | invokeStmt(InvokeExp invokeExpression)
  | nop()
  ;        
 
 data CaseStmt 
   = caseOption(int option, GotoStmt targetStmt) 
   | defaultOption(GotoStmt targetStmt)
   ; 

data GotoStmt = gotoStmt(Label label); 

data Expression 
  = newInstance(Type instanceType)
  | newArray(Type baseType, list[ArrayDescriptor] dims)
  | cast(Type toType, Immediate immeadiate)
  | instanceOf(Type baseType, Immediate immediate)
  | invokeExp(InvokeExp expression)
  | arraySubscript(Name name, Immediate immediate)
  | stringSubscript(str string, Immediate immediate)
  | localFieldRef(Name local, Name className, Type fieldType, Name fieldName)
  | fieldRef(Name className, Type fieldType, Name fieldName)
  | and(Immediate lhs, Immediate rhs)
  | or(Immediate lhs, Immediate rhs)
  | xor(Immediate lhs, Immediate rhs)
  | reminder(Immediate lhs, Immediate rhs)
  | cmp(Immediate lhs, Immediate rhs) 
  | cmpg(Immediate lhs, Immediate rhs) 
  | cmpl(Immediate lhs, Immediate rhs)
  | cmpeq(Immediate lhs, Immediate rhs) 
  | cmpne(Immediate lhs, Immediate rhs) 
  | cmpgt(Immediate lhs, Immediate rhs) 
  | cmpge(Immediate lhs, Immediate rhs)
  | cmplt(Immediate lhs, Immediate rhs) 
  | cmple(Immediate lhs, Immediate rhs)
  | shl(Immediate lhs, Immediate rhs) 
  | shr(Immediate lhs, Immediate rhs) 
  | ushr(Immediate lhs, Immediate rhs)
  | plus(Immediate lhs, Immediate rhs) 
  | minus(Immediate lhs, Immediate rhs) 
  | mult(Immediate lhs, Immediate rhs) 
  | div(Immediate lhs, Immediate rhs)
  | lengthOf(Immediate immediate)
  | neg(Immediate immediate) 
  | immediate(Immediate immediate)
  ;
  
data ArrayDescriptor 
  = fixedSize(int size)
  | variableSize() 
  ;
  
data InvokeExp
  = specialInvoke(Name local, MethodSignature sig, list[Immediate] args)
  | virtualInvoke(Name local, MethodSignature sig, list[Immediate] args)
  | interfaceInvoke(Name local, MethodSignature sig, list[Immediate] args)
  | staticMethodInvoke(MethodSignature sig, list[Immediate] args)
  | dynamicInvoke(str string, UnnamedMethodSignature usig, list[Immediate] args1, MethodSignature sig, list[Immediate] args2)
  ;   

data FieldSignature 
  = fieldSignature(Name className, Type fieldType, Name fieldName)
  ; 
  
data MethodSignature 
  = methodSignature(Name className, Type returnType, list[Type] formals)
  ; 
  
data UnnamedMethodSignature 
  = unnamedMethodSignature(Type returnType, list[Type] formals)
  ;   
    
data Modifier 
  = Abstract()
  | Final()
  | Native()
  | Public() 
  | Protected() 
  | Private() 
  | Static() 
  | Synchronized() 
  | Transient() 
  | Volatile() 
  | Strictfp() 
  | Enum() 
  | Annotation()
  ;
  
/**
 * I think that we will have to review this 
 * type declaration.  
 */  
data Type
  = TByte()
  | TBoolean()
  | TShort()
  | TCharacter()
  | TInteger()
  | TFloat()
  | TDouble()
  | TLong()
  | TObject(Name name)  
  | TArray(Type baseType)
  | TVoid()
  | TString()
  | TNull()
  | TUnknown()            // it might be useful in the first phase of Jimple Body creation 
  ;  
  
Type object() = TObject("java.lang.Object");