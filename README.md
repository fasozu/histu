# HIStU

HIStU: Honey, I Shrunk the Urls - Url Shortener

## How random code is generated

The random code for the shorthen url is generated randomly from the option's array configured in `short_code_generator_char_options`.

The lenght of the code depends on various factors:

1. Number of options to generate each char (more options equals less lenght)
2. Number of codes generated
3. Permutations with repetition space usage

The idea is to keep an unused percentage of permutations before increase the code lenght.

This is for two main things:

1. Insert some dificulty so human generated codes are not valid.
2. Control the probability a generated random code was generated before.

There is another config variable to control how many tries to do before giving up if the generated code was generated before. 

### Example

Let options dictionary be digits 0..9 and an usage of 20%.  

This way it can generate 2 random codes of length 1 before to start with the next step. 

With lenght of 2 the total space is 100 so the number of codes is 20 before start with length 

In this case, the max probability to generated an existing code is 20%.

The formula to calculate what should be the lenght to generate is:

```{ruby}
minimumSpace = (numberRecords/probabilityRepeated).ceil()
lengthCode = Math::log(minimumSpace,numberOptions).ceil()
```

*numberRecords*: total codes generated so far

*probabilityRepeated*: The numberRecords's relation to the full space, in the example, given 20% the value has to be configured to 0.2

*minimumSpace*: Minimum space to guarantee, continuing with example, if there is currently 3 codes generated, the minimum space is `3/0.2 = 15`

*numberOptions*: Number of options to select each code's char . For the example 0..9 this number is 10

*lenghtCode*: How many char has to contain the generated code, For the example: `Math::log(15,10) = 1.17...`, with ceil, the lenght has to be minimum `2`.

