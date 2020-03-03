/// Author: Nicolás David Muñoz Cuervo.

/// Class that creates what one may think of as an enum of classes.
class Result {
    Result._();
    
    /// A factory method that creates the enum that represents the [Success] case,
    /// this enum receives a [data] as a parameter in case some [data] need to be passed.
    factory Result.success(Object data) = Success;
    
    /// A factory method that creates the enum that represents the [Failure] case,
    /// this enum receives a [exception] as a parameter to be handled.
    factory Result.failure(Exception exception) = Failure;
}

/// The success definition class of [Result].
class Success extends Result {
    Success(this.data): super._();
    final Object data;
}

/// The failure definition class of [Result].
class Failure extends Result {
    Failure(this.data): super._();
    final Exception data;
}