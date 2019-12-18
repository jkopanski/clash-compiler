.. _prelude:

Clash Prelude
=============

Basic Types
-----------

The Clash prelude includes many different numeric types, which are used to
safely define other types / functions. These include, but may not be limited to

- Type level natural numbers (``Nat``), which allow numbers to be used in
  types. Conceptually, this is similar to *const generics* in *C++*.

  It is possible to have term level values which refer to a type level number.
  This is called ``SNat n`` (for *singleton natural number*). These are defined
  up to 1024 with the prefix "d" (e.g. ``d256``).

- ``Unsigned n`` and ``Signed n`` numbers with an arbitrary width (given as a
  type level natural number). These allow fixed-width arithmetic to be used on
  arbitrary numbers.

- ``Index n`` provides natural numbers up to an arbitrary value (given as a
  type level natural number). These allow indexing into fixed width structures
  like ``Vec n a``.

Another commonly used type is ``BitVector n``. This provides a fixed size
vector of ``Bit`` values which can be indexed, and used to perform *unsigned
integer arithmetic*. Any type that can be marshalled to / from a ``BitVector
n`` implements the ``BitPack`` class, which defines the conversion.

.. note:: It is also possible to derive instances of ``BitPack`` using
  ``Generic``, by writing ``deriving (Generic, BitPack)`` in the type
  definition. This automatically determines how to do the conversion at
  compile-time.

More generally, there is a ``Vec n a`` type which allows collections of
arbitrary values to be used. These vectors are tagged with their length, to
prevent out of bounds access at compile-time.

Synthesis Domains
-----------------

Synchronous circuits have a synthesis domain, which determines the behaviour
of things which can affect signals in the domain. Domains consist of

- a name, which uniquely refers to the domain
- the clock period in ps
- the active edge of the clock
- whether resets are synchronous (edge-sensitive) or not
- whether the initial (power up) behaviour is defined
- whether resets are high or low polarity

The prelude provides some common domains, namely ``XilinxSystem`` and
``IntelSystem`` for the standard configurations of each vendor. There is also
a generic domain, ``System``, which can be used for vendor-agnostic purposes
(i.e. writing a generic test bench).

A value in a synchronous circuit is wrapped in the ``Signal dom a`` type, which
specifies the synthesis domain and the type of value. Any function which needs
access to a domain can use the constraints ``HasDomain`` (to find it's domain)
or ``KnownDomain`` (to extract configuration).

The default API exposed by the prelude is implicit with regards to clocks,
reset lines and enable lines -- as these can be determined at compile time.
However, if they are needed the ``Clash.Explicit`` module contains explicit
versions of the API which expose these directly in function arguments. It is
also possible to use functions like ``exposeClockResetEnable`` to turn an
implicitly defined function to an explicitly defined function.

State Machines
--------------

Moore

Mealy

RAM and ROM
-----------

RAM

ROM

BlockRAM

Undefined
---------

XException

ShowX

NFDataX

