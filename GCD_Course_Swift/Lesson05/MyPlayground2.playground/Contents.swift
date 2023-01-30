print("Введите возраст")
guard let input = readLine(),
    let age = Int(input) else {
        print("Неверный ввод. Повторите попытку")
}
if age < 5 {
    print ("Пора идти в садик")
} else if age == 5 {
    print ("Пора идти в прескул")
} else if (age > 5) && (age <= 18) {
    let grade = age - 5
    print ("Пора идти в \(grade) класс")
} else {
    print ("Пора идти в университет")
}
