module SIMDTypes
if isdefined(Base, :Experimental) &&
   isdefined(Base.Experimental, Symbol("@max_methods"))
    @eval Base.Experimental.@max_methods 1
end

# using Static: StaticInt

struct Bit; data::Bool; end # Dummy for Ptr
@inline Base.convert(::Type{Bool}, b::Bit) = getfield(b, :data)

const FloatingTypes = Union{Float16,Float32,Float64}
const SignedHW = Union{Int8,Int16,Int32,Int64}
const UnsignedHW = Union{UInt8,UInt16,UInt32,UInt64}
const IntegerTypesHW = Union{SignedHW,UnsignedHW}
# const IntegerTypes = Union{StaticInt,IntegerTypesHW}

@static if VERSION >= v"1.12.0-DEV"
    const NativeTypesExceptBitandFloat16 = Union{Bool,Float32,Float64,SignedHW,UnsignedHW}
else
    const NativeTypesExceptBitandFloat16 = Union{Bool,Base.HWReal}
end
const NativeTypesExceptFloat16 = Union{NativeTypesExceptBitandFloat16, Bit}
const NativeTypesExceptBit = Union{Bool,Base.HWReal}
const NativeTypes = Union{NativeTypesExceptBit, Bit}

const _Vec{W,T<:Number} = NTuple{W,Core.VecElement{T}}

end
