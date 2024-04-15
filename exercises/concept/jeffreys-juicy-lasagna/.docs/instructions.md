# Instructions

You're going to write some code to help you cook a lasagna from your favorite cookbook.

There are five tasks, all related to the process of cooking your recipe.

## 1. Define expected bake time in minutes

Define an `ExpectedBakeTime` constant that returns how many minutes the lasagna should bake in the oven.
According to your cookbook, the Lasagna should be in the oven for 40 minutes:

```powershell
> $ExpectedBakeTime
> 40
```

## 2. Calculate remaining bake time in minutes

Implement the `RemainingTime` function that takes the actual minutes the lasagna has been in the oven as an argument and returns how many minutes the lasagna still needs to bake based on the `ExpectedBakeTime`.

```powershell
> RemainingTime -Minutes 30
> 10
```

## 3. Calculate preparation time in minutes

Implement the `PreparationTime` function that takes the number of layers you want to add to the lasagna as an argument and returns how many minutes you would spend making them.
Assume each layer takes 2 minutes to prepare.

```powershell
> PreparationTime -Layers 2
> 4
```

## 4. Calculate total elapsed cooking time (prep + bake) in minutes

Implement the `ElapsedTime` function that has two parameters: `Layers` (_the number of layers added to the lasagna_) and `Minutes` (_the number of minutes the lasagna has been baking in the oven_).
This function should return the total number of minutes you've been cooking, or the sum of your preparation time and the time the lasagna has already spent baking in the oven.

```powershell
> ElapsedTime -Layers 3 -Minutes 20
> 26
```

## 5. Create a notification that the lasagna is ready

Define the `Notification` function that does not take any arguments and returns a message indicating that the lasagna is ready to eat.

```powershell
> Notification
> "Lasagna's ready!"
```
